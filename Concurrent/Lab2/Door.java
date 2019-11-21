/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 2 */

import java.util.Random;

public class Door implements Runnable{
  public static volatile int garden; // Shared variable between threads that stores the number of
  // people in the garden
  private String name; //  Private varible that stores the name of the door
  private int enter; // Private int that stores the number of people that had entered using the door
  private int exited; // Private int that stores the number of people that had entered using the door
  private Door otherDoor; // Variable that references the other door

  //  constructor that takes the name of the door
  public Door(String name) {
    this.name = name;
    garden = 0; // Initializes the volatile variable in 0
    enter = 0;
    exited = 0;
    this.otherDoor = null;
  }

  // Setter of the other door
  public void setDoor(Door otherDoor) {
    this.otherDoor = otherDoor;
  }

  // synchronized function that uses a lock to check and add a 1 to the value garden
  public synchronized void increment_people() {
    garden++;
    this.enter++;
    // Print the name of the door and the total of people inside the garden and the control values
    System.out.println("----------------------------------------------------");
    System.out.println("A person entered the garden via the " + name + " door.");
    System.out.println("Total of people inside the garden :" + garden);
    System.out.println("Total of people that entered via the " + name + "door :" + enter);
    System.out.println("Total of people that exited via the " + name + "door :" + exited);
    System.out.println("Total of people that entered via the " + otherDoor.name + "door :" + otherDoor.enter);
    System.out.println("Total of people that exited via the " + otherDoor.name + "door :" + otherDoor.exited);
    System.out.println("----------------------------------------------------");
  }

  // synchronized function that uses a lock to check and reduces a 1 to the value garden
  public synchronized void decrement_people() {
    garden--;
    exited++;
    // Print the name of the door and the total of people inside the garden and the control values
    System.out.println("----------------------------------------------------");
    System.out.println("A person exited the garden via the " + name + " door.");
    System.out.println("Total of people inside the garden :" + garden);
    System.out.println("Total of people that entered via the " + name + "door :" + enter);
    System.out.println("Total of people that exited via the " + name + "door :" + exited);
    System.out.println("Total of people that entered via the " + otherDoor.name + "door :" + otherDoor.enter);
    System.out.println("Total of people that exited via the " + otherDoor.name + "door :" + otherDoor.exited);
    System.out.println("----------------------------------------------------");
  }

  // Override run function
  @Override
  public void run() {
    // Create a random object
      Random random = new Random();
      int i = 0;
      while(i++ < 5) {
        // Create a random number between 0 and 2
        int person = random.nextInt(2);
        // If the random number is equal to 0
        if(person == 0) {
          // call the synchronized function to add 1 to the garden
          increment_people();
          try {
            Thread.sleep(random.nextInt(100)); // sleep a random time between 0 and 99 (as if the person is inside the garden)
          } catch (InterruptedException e) { // Catch error
            Thread.currentThread().interrupt();
          }
          synchronized(this) { // Create a synchronized segment to check that
            if(garden > 0) { // the current value of the garden is bigger than 0
              decrement_people(); // If so decrement by one the number of people inside the garden
            }
          }
        }
      }
  }

  public static void main(String args[]) throws InterruptedException{
    Door west = new Door("West"); // Create two door objects west and east
    Door east = new Door("East");
    west.setDoor(east);
    east.setDoor(west);
    Thread w = new Thread(west); // Create Threads from those objects
    Thread e = new Thread(east);
    w.start(); // Start the threads
    e.start();
  }


}
