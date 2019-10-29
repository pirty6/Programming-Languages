/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 3 */

// Base class Animal
public class Animal {
  int race_length; // Total length of the race
  int current_length; // how much has the animal ran
  boolean finish; // Boolean variable to check who finished the race

  // Animal default constructor
  public Animal() {
    this.race_length = 1000;
    this.current_length = 0;
    this.finish = false;
  }

  // Animal personalized constructor
  public Animal(int race_length) {
    this.race_length = race_length;
    this.current_length = 0;
    this.finish = false;
  }

  // Getters
  public boolean get_finished() {
    return finish;
  }

  public int get_current() {
    return current_length;
  }

  public int get_race_length() {
    return race_length;
  }

}
