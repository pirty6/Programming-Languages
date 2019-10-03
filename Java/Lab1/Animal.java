public class Animal {
  int race_length, current_length;
  boolean finish;

  public Animal() {
    this.race_length = 1_000_000;
    this.current_length = 0;
    this.finish = false;
  }

  public Animal(int race_length) {
    this.race_length = race_length;
    this.current_length = 0;
    this.finish = false;
  }

  public boolean get_finished() {
    return finish;
  }

  public int get_current() {
    return current_length;
  }

}
