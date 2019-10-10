﻿// AUTHOR: Kriston Sanders
// DATE: Oct 2019

// precondition/postconditions?

/* INTERFACE INVARIANT: 
    Child class if imageCollage. Supports image query tracking, image swaps (and tracking),
    and image search per parent class.  Additionally, images from base can be omitted
    per the omitted data member, which can later be updated. Object retains omitted images,
    just does not display them. Images are only omitted from even indexes.
*/

/* IMPLEMENTATION INVARIANT: 
    Class is required to have a display function that returns image list (uint) 
    per the interface contract.
*/

using System;
using System.Collections.Generic;
using System.Linq;

namespace InternalPurchaseAdmin.DAL
{
    public class NumberRandomizer
    {
        /// <summary>Gets a random number between two values, inclusive.</summary>
        /// <param name="lowerInclusive">The lower inclusive value.</param>
        /// <param name="upperInclusive">The upper inclusive value.</param>
        /// <returns>A random int within the supplied bounds.</returns>
        public static int GetRandomNumber(int lowerInclusive, int upperInclusive)
        {
            Random rnd = new Random();
            int result = rnd.Next(lowerInclusive, upperInclusive + 1);
            return result;
        }

        /// <summary>Gets an array of unique numbers within a supplied range, 
        /// of a specified quantity.</summary>
        /// <param name="qty">The number of desired elements.</param>
        /// <param name="lowerInclusive">The lower inclusive value.</param>
        /// <param name="upperInclusive">The upper inclusive value.</param>
        /// <returns>Array of unique ints.</returns>
        public static int[] GetUniqueNumArray(int qty, int lowerInclusive, int upperInclusive)
        {
            var result = new HashSet<int>();
            int num;

            for (int i = 0; i < qty; i++)
            {
                while (result.Contains(num = GetRandomNumber(lowerInclusive, upperInclusive))) { }
                result.Add(num);
            }

            return result.ToArray<int>();
        }

        /// <summary>Gets an array of random numbers within a supplied range, of a specified quantity. Duplicates are allowed.</summary>
        /// <param name="qty">The desired quantity.</param>
        /// <param name="lowerInclusive">The lower inclusive value.</param>
        /// <param name="upperInclusive">The upper inclusive value.</param>
        /// <returns>Array of ints.</returns>
        public static int[] GetRandomNumArray(int qty, int lowerInclusive, int upperInclusive)
        {
            var result = new int[qty];

            for (int i = 0; i < qty; i++)
                result[i] = GetRandomNumber(lowerInclusive, upperInclusive);

            return result;
        }
    }
}
