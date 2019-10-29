/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 3 */

import java.util.Random;

public class Rabbit extends Animal implements Runnable {
  int sleeping_time; // Time that the rabbit will sleep

  // Default constructor where the rabbit will always sleep 100ms
  public Rabbit() {
    super();
    this.sleeping_time = 100;
  }

  // Personalized constructor
  public Rabbit(int race_length, int sleeping_time) {
    super(race_length);
    this.sleeping_time = sleeping_time;
  }

  // Override of the run function
  public void run() {
    // Create random object
    Random random = new Random();
    // While the thread is alive and running (vivito y coleando) and the total
    // amount that the turtle has ran is less than the total length continue doing
    // the same
    while(current_length < race_length && !Thread.currentThread().isInterrupted()) {
      // Get a random number from 1000 to 500 to add it to how much the rabbit ran
      int ran = random.nextInt((1000 - 500) + 1) + 500;
      current_length += ran;
      System.out.println("The rabbit ran " + ran + " mts. Total = " + current_length);
      // If the rabbit finished the race end the loop and change the value of finish from
      // false to true
      if(current_length >= race_length) {
          finish = true;
          break;
      }
      // try to sleep
      try {
        System.out.println("The rabbit is sleeping...");
        Thread.sleep(sleeping_time);
        System.out.println("The rabbit woke up");
      } catch(InterruptedException ex) {
        // If thread has been interrupted then kill themselves
        System.out.println("The rabbit did not finished the race");
        Thread.currentThread().interrupt();
      }
    }
  }
}
