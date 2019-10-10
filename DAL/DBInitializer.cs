// AUTHOR: Kriston Sanders
// DATE: Oct 2019

/* 
    Used to setup database with mock data for testing. Will create tables, 
    run external sql files containing mock data, and generate random
    data for linking tables.
*/

using InternalPurchaseAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace InternalPurchaseAdmin.DAL
{
    public static class DbInitializer
    {
        /// <summary>Runs SQL file from folder.</summary>
        /// <param name="context">The DB context.</param>
        /// <param name="foldername">  The name of folder containing SQL file.</param>
        /// <param name="filename">The name of the SQL file.</param>
        private static void RunSQLFile(PurchaseAdminContext context, string foldername, string filename)
        {
            if (filename.EndsWith(".sql"))
            {
                string path = Path.Combine(Environment.CurrentDirectory, foldername, filename);
                string sqlScript = File.ReadAllText(path);
                context.Database.ExecuteSqlCommand(sqlScript);
            }
        }

        /// <summary>Runs all SQL files from folder.</summary>
        /// <param name="context">The DB context.</param>
        /// <param name="foldername">  The name of folder containing SQL files.</param>
        private static void RunAllSQLFromFolder (PurchaseAdminContext context, string foldername)
        {
            DirectoryInfo filepath = new DirectoryInfo(Path.Combine(Environment.CurrentDirectory, foldername));

            foreach (FileInfo file in filepath.GetFiles())
            {
                string _FileName = file.Name;
                if (_FileName.EndsWith(".sql"))
                    RunSQLFile(context, filepath.ToString(), file.ToString());
            }
        }

        /// <summary>Gets random ID from array of IDs.</summary>
        /// <param name="ids">  The array of IDs to pick from.</param>
        /// <returns>A random ID from the array.</returns>
        private static int GetRandomID(int[] ids)
        {
            int randIndex = NumberRandomizer.GetRandomNumber(0, ids.Length - 1);
            return ids[randIndex];
        }

        /// <summary>  Assigns a random ID from one array to each ID from the first. 
        /// Loads into a given dictionary for further appending.</summary>
        /// <param name="set">  The dictionary to load matches into.</param>
        /// <param name="loop">The array for which each element will be assigned IDs from another.</param>
        /// <param name="randomize">  The array to randomly assign to the loop array.</param>
        private static void GetIDPairs(Dictionary<int, HashSet<int>> set, int[] loop, int[] randomize)
        {
            int randID;
            foreach (int i in loop)
            {
                randID = GetRandomID(randomize);
                // append value or add key
                if (set.ContainsKey(randID))
                    set[randID].Add(i);
                else
                    set.Add(randID, new HashSet<int> { i });
            }
        }

        /// <summary>  Appends dictionary with additional matches to ensure every pair unique.</summary>
        /// <param name="set">The dictionary to append.</param>
        /// <param name="qty">The number of desired additions.</param>
        /// <param name="left">The left array used for keys.</param>
        /// <param name="right">The right array used for values.</param>
        private static void AddUniqueIDPairs(Dictionary<int, HashSet<int>> set, int qty, int[] left, int[] right)
        {
            int randLeftID;
            int randRightID;

            for (int i = 0; i < qty; i++)
            {
                randLeftID = GetRandomID(left);
                randRightID = GetRandomID(right);
                if (set.ContainsKey(randLeftID))
                {
                    // pair must not already exist
                    while (set[randLeftID].Contains(randRightID))
                    {
                        randRightID = GetRandomID(right);
                    };
                    set[randLeftID].Add(randRightID);
                }
                else
                    set.Add(randLeftID, new HashSet<int> { randRightID });
            }
        }

        /// <summary>  Gets an array of IDs from User table by the assigned UserRole.</summary>
        /// <param name="userRoleID">The user role identifier.</param>
        /// <param name="context">The DB context.</param>
        /// <returns>Array of user IDs matching the supplied role.</returns>
        private static int[] GetUsersByRole(int userRoleID, PurchaseAdminContext context)
        {
            return context.Users
                .Join(context.UserRoles,
                    u => u.ID,
                    r => r.UserID,
                    (u, r) => new { u.ID, r.RoleID })
                .Where(r => r.RoleID == userRoleID)
                .Select(i => i.ID)
                .ToArray();
        }

        /// <summary>Initializes the database by creating tables and stored procedures, 
        /// then seeding with data for testing.</summary>
        /// <param name="context">The DB context.</param>
        public static void Initialize(PurchaseAdminContext context)
        {
            context.Database.EnsureCreated();

            string fileFoldername = @"DAL\";
            string triggerFoldername = @"SQLTriggers\";
            string procedureFoldername = @"SQLProcedures\";
            string dropTablesFilename = "DropAllTables.sql";
            string addTablesFilename = "AddAllTables.sql";
            string mockDataFilename = "AddMockData.sql";
            int userIDSeed = 1000;  // DB IDs are seeded to begin at 1000
            int staffRoleID = 1000;
            int facultyRoleID = 1001;
            int studentRoleID = 1002;
            int sharedTypeID = 1001;
            double staffPercent = .3;   // percent of users we want to be staff
            double facultyPercent = .2; // percent of users we want to be faculty
            double staffStudentPercent = .05;   // percent of staff we want to also be students
            int userQty = Convert.ToInt32(context.Users.Count()) - 1; // exclude system user
            int staffQty = Convert.ToInt32(staffPercent * userQty);   // quantity of users to make staff
            int facultyQty = Convert.ToInt32(facultyPercent * userQty);   // quantity of users to make faculty
            int staffStudentQty = Convert.ToInt32(staffStudentPercent * userQty); // quantity of staff to make students
            int extraMgrQty = 8;    // quantity of users we want to manage multiple accounts
                                    // additional count of users to grant access to shared account 
                                    //  may be additional account(s) for fac-staff or for workstudy students
            int extraUserAccountQty = 32;
            const int START_AT_ZERO = 0;


            try
            {
                // uncomment to completely reset database
                //RunSQLFile(context, fileFoldername, dropTablesFilename);

                // Create tables if not exist
                RunSQLFile(context, fileFoldername, addTablesFilename);

                // Look for any users.
                if (context.Users.Any())
                {
                    return;   // DB has been seeded
                }

                // create triggers, stored procedures, and seed with mock data
                RunAllSQLFromFolder(context, fileFoldername + triggerFoldername);
                RunAllSQLFromFolder(context, fileFoldername + procedureFoldername);
                RunSQLFile(context, fileFoldername, mockDataFilename);

                               
                // get IDs and count for all shared accounts
                int[] allSharedAccounts = context.Accounts
                    .Where(a => a.AccountTypeID == sharedTypeID)
                    .Select(i => i.ID)
                    .ToArray();
                int accountCount = allSharedAccounts.Length;


                // seed BillingCode table
                var billingCodes = new BillingCode[accountCount];
                // generate unique 10-digit codes
                int[] codes = NumberRandomizer.GetUniqueNumArray(accountCount, 90000000, 99999999);

                for (int i = 0; i < accountCount; i++)
                {
                    billingCodes[i] = new BillingCode { Code = codes[i], AccountID = allSharedAccounts[i] };
                }

                foreach (BillingCode c in billingCodes)
                {
                    context.BillingCodes.Add(c);
                }
                context.SaveChanges();

                
                // seed UserRole table
                var userRoles = new UserRole[userQty + staffStudentQty];
                // lowerInclusive should start at 1001 to exclude the system user
                var randUsers = NumberRandomizer.GetUniqueNumArray(userQty, 1 + userIDSeed, userQty + userIDSeed);

                //assign staff roles
                for (int i = 0; i < staffQty; i++)
                {
                    userRoles[i] = new UserRole { UserID = randUsers[i], RoleID = staffRoleID };
                }
                //assign faculty roles
                for (int i = staffQty; i < facultyQty + staffQty; i++)
                {
                    userRoles[i] = new UserRole { UserID = randUsers[i], RoleID = facultyRoleID };
                }
                //assign student roles
                for (int i = facultyQty + staffQty; i < userQty; i++)
                {
                    userRoles[i] = new UserRole { UserID = randUsers[i], RoleID = studentRoleID };
                }
                // make some staff also students by randomizing the index numbers of randUsers within the staff range
                var randStaff = NumberRandomizer.GetUniqueNumArray(staffStudentQty, START_AT_ZERO, staffQty - 1);
                for (int i = userQty; i < userRoles.Length; i++)
                    userRoles[i] = new UserRole { UserID = randUsers[randStaff[i - userQty]], RoleID = studentRoleID };

                foreach (UserRole r in userRoles)
                {
                    context.UserRoles.Add(r);
                }
                context.SaveChanges();


                // subarrays by role to help comprehension in subsequent actions
                var allStaff = new int[staffQty];
                Array.Copy(randUsers, START_AT_ZERO, allStaff, START_AT_ZERO, staffQty);

                var allFaculty = new int[facultyQty];
                Array.Copy(randUsers, staffQty, allFaculty, START_AT_ZERO, facultyQty);


                // seed Manager table
                var managers = new List<Manager>();
                // dictionary ensures no duplicate pairs
                var managerSelection = new Dictionary<int, HashSet<int>>();

                // assign a random manager to every shared account
                GetIDPairs(managerSelection, allSharedAccounts, allStaff);
                // assign additional managers to some shared accounts (user cannot manage any one account more than once)
                AddUniqueIDPairs(managerSelection, extraMgrQty, allStaff, allSharedAccounts);

                foreach (KeyValuePair<int, HashSet<int>> set in managerSelection)
                {
                    foreach (int i in set.Value)
                    {
                        managers.Add(new Manager { UserID = set.Key, AccountID = i });
                    }
                }

                foreach (Manager m in managers)
                {
                    context.Managers.Add(m);
                }
                context.SaveChanges();


                // seed UserAccount table
                var userAccounts = new List<UserAccount>();
                // dictionary ensures no duplicate pairs
                var accountSelection = new Dictionary<int, HashSet<int>>();

                // assign all staff to a random shared account
                GetIDPairs(accountSelection, allStaff, allSharedAccounts);
                // assign all faculty to a random shared account
                GetIDPairs(accountSelection, allFaculty, allSharedAccounts);
                // assign additional accounts to some users irrespective of their role
                AddUniqueIDPairs(accountSelection, extraUserAccountQty, randUsers, allSharedAccounts);

                foreach (KeyValuePair<int, HashSet<int>> set in accountSelection)
                {
                    foreach (int i in set.Value)
                    {
                        userAccounts.Add(new UserAccount { UserID = i, AccountID = set.Key });
                    }
                }

                foreach (UserAccount a in userAccounts)
                {
                    context.UserAccounts.Add(a);
                }
                context.SaveChanges();
            }
            catch (Exception e)
            {
                Console.WriteLine("Database seeding failed.");
            }
        }
    }
}

