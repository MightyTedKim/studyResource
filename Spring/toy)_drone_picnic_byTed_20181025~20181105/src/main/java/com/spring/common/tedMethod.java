package com.spring.common;

public class tedMethod {
	//validation empty check
    public static boolean hasValues(String... strs) {
        boolean hasValues = true;
        for (String str : strs) {
          if (str == null || str.length() == 0) {
            hasValues = false;
            break;
          }
        }
        return hasValues;
	}  
}
