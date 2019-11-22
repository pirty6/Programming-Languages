/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 3 */

import java.util.Scanner;

public class Race {
  Rabbit rabbit; // Rabbit object
  Turtle turtle; // turtle object

  // Default constructor
  public Race() {
    this.rabbit = new Rabbit();
    this.turtle = new Turtle();
  }

  // Personalized constructor
  public Race(int race_length, int sleeping_time, int turtle_speed) {
    this.rabbit = new Rabbit(race_length, sleeping_time);
    this.turtle = new Turtle(race_length, turtle_speed);
  }

  // Function race
  public void race() throws InterruptedException{
    // Initializes the threads from the rabbit and turtle objects
    Thread r = new Thread(rabbit);
    Thread t = new Thread(turtle);
    // Start the threads
    t.start();
    r.start();

    // While the thread rabbit or the thread turtle is alive
    while(r.isAlive() || t.isAlive()) {
      // Wait 100ms for both threads to start at the same time
      r.join(100);
      t.join(100);
      // Checks if the rabbit already finished
      if(rabbit.get_finished()) {
        System.out.println("The rabbit won the race!");
        // Interrupts the turtle thread
        t.interrupt();
        // Wait for it to die completely
        t.join();
        // Get out of the while
        break;
      }
      // Checks if the turtle finished the race
      if(turtle.get_finished()) {
        System.out.println("The turtle won the race!");
        // Interrupts the rabbit thread
        r.interrupt();
        // Wait for it to die completely
        r.join();
        // Get out of the while
        break;
      }
    }
    System.out.println("The race has finished");
  }

  public static void main(String args[]) throws InterruptedException{
    System.out.println("First Race:");
    // Initializes the Race object with the default constructors
    Race race1 = new Race();
    race1.race();

    System.out.println("\nSecond Race:");
    // Initialize Race object with length of the race, rabbit's sleeping time and
    // speed of the turtle
    Race race2 = new Race(1000, 10, 5);
    race2.race();

    System.out.println("\nThird Race:");
    // Initialize Race object with length of the race, rabbit's sleeping time and
    // speed of the turtle
    Race race3 = new Race(1000, 100, 100);
    race3.race();
  }
}
