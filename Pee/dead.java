import java.util.*;

public class dead {
  public static int getSum(List<Integer> sales, int low, int high) {
    if(low == high) {
      return sales.get(low);
    }
    if(low + 1 == high) {
      return sales.get(low) + sales.get(high);
    }
    int mid = ((high - low) / 2) + low;

  return 0;
  }

  public static int balancedSum(List<Integer> sales) {
      return getSum(sales, 0, sales.size());
  }


  public static int countPalindrome(String s) {

    char inputArray[] = ("@" + s + "#").toCharArray();
    int radius[][] = new int[2][s.length() + 1];
    Set<String> palindromes = new HashSet<String>();
    int max = 0;
    for(int i = 0; i <= 1; i++) {
      radius[i][0] = max = 0;
      int j = 1;
      while(j <= s.length()) {
        palindromes.add(Character.toString(inputArray[j]));
        while(inputArray[j - max - 1] == inputArray[j + i + max]) {
          max++;
        }
        radius[i][j] = max;
        int k = 1;
        while((radius[i][j - k] != max - k) && (k < max)) {
          radius[i][j + k] = Math.min(radius[i][j - k], max - k);
          k++;
        }
        max = Math.max(max - k, 0);
        j += k;
      }
    }
    for(int i = 1; i <= s.length(); i++) {
      for(int j = 0; j <= 1; j++) {
        for(max = radius[j][i]; max > 0; max--) {
          palindromes.add(s.substring(i - max - 1, max + j + i -1));
        }
      }
    }
    System.out.println(palindromes.toString());
    return palindromes.size();
  }

  public static long parking(List<Long> cars, int k) {
    if(k > cars.size()) {
      return cars.get(0) - cars.get(cars.size() - 1);
    }
    Collections.sort(cars);
    long min = Integer.MAX_VALUE;
    for(int i = 0; i <= (cars.size() - k); i++) {
        min = Math.min(cars.get(i + k - 1) - cars.get(i), min);
    }
    return min + 1;
  }



  public static void main(String[] args) {
    List<Integer> l = new ArrayList<Integer>();
    l.add(1);
    l.add(2);
    l.add(3);
    l.add(3);
    //System.out.println(balancedSum(l));

    //String p = "mokkori";
    //System.out.println(countPalindrome("aabaa"));
    //System.out.println(countPalindrome("aabaa"));
    List<Long> cars = new ArrayList<>();
    cars.add(4L);
    System.out.println(parking(cars, 3));
  }
}
