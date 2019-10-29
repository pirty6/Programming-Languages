/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 3 */

import java.util.Random;

// Class Turtle that implements the Runnable object to be able to be a thread
public class Turtle extends Animal implements Runnable{
  int turtle_speed; // Speed of the turtle

  // Default constructor
  public Turtle() {
    super(); // extends the class Animal
    turtle_speed = -1;
  }

  // Personalized constructor
  public Turtle(int race_length, int turtle_speed) {
    super(race_length);
    this.turtle_speed = turtle_speed;
  }

  // Override of the run function for the thread
  public void run() {
    // Creates random object
    Random random = new Random();
    // Try to run until it finishes or it is interrupted (Really important)
    try {
      // While the thread is alive and running (vivito y coleando) and the total
      // amount that the turtle has ran is less than the total length continue doing
      // the same
      while(current_length < race_length && !Thread.currentThread().isInterrupted()) {
        int ran;
        // if the turtle was initialized with the default constructor then create
        // a random number between 10 and 3
        if(turtle_speed == -1){
          ran = random.nextInt((10 - 3) + 1) + 3;
        } else {
          // Else use the speed given by the user
          ran = turtle_speed;
        }
        // Add it to how much it has ran
        current_length += ran;
        System.out.println("The turtle ran " + ran + " mts. Total = " + current_length);
        // If the turtle finished the race change the value of finish from false to true
        if(current_length >= race_length) {
          finish = true;
          break;
        }
        Thread.sleep(10);
      }
    } catch(InterruptedException e) { // If the thread has been interrupted then kill
      // themselves again
      System.out.println("The turtle did not finished the race");
      Thread.currentThread().interrupt();
    }
  }
}
