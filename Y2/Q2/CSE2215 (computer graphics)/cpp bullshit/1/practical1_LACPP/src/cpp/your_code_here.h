#pragma once
#include <iostream>
#include <algorithm>
#include <array>
#include <cmath>
#include <numeric>
#include <span>
#include <tuple>
#include <vector>

// ==================================
// ========    Exercise 1    ========
// ==================================
std::pair<float, float> statistics(std::span<const float> values)
{
   if(values.size() <= 0) return std::make_pair(0.0f, 0.0f);
    // Your solution goes here
    float total = 0.0f;
    for(int i = 0; i < values.size(); i++){
   
       total += values[i];

    }

    float mean = total / values.size();

    float squaredErrors = 0.0f;
    for(int i = 0; i < values.size(); i++){

       squaredErrors += pow(abs(values[i] - mean), 2);

    }
//    printf("errors: %f\n", squaredErrors);

    float stddev = sqrt(squaredErrors / values.size());
    std::pair<float, float> pair = std::make_pair(mean, stddev);
    
    return pair;
}

// ==================================
// ========    Exercise 2    ========
// ==================================
struct Tree {
    float value;
    std::vector<Tree> children;
};

float countSubTree(const Tree& tree, bool countThisLayer, bool countOnlyEven);
// Your implementation goes here. Feel free to define helper functions/structs/classes in this
// file if you need to. Make sure to put them above this function to prevent linker warnings.
float countTree(const Tree& tree, bool countOnlyEvenLevels)
{
    // Your solution goes here
    return countSubTree(tree, true, countOnlyEvenLevels);
}

float countSubTree(const Tree& tree, bool countThisLayer, bool countOnlyEven){

   //printTrueRecurse(std::cout, tree, 0);

   float total;
   if(countThisLayer){
      total = tree.value;
   }else{
      total = 0.0f;
   }
   for(int i = 0; i < tree.children.size(); i++){

      if(countOnlyEven){
         total += countSubTree(tree.children[i], !countThisLayer, countOnlyEven);
      }else{
         total += countSubTree(tree.children[i], true, countOnlyEven);
      }

   }

   return total;

}

