import java.util.Random;

public class Turtle extends Animal implements Runnable{
  int turtle_speed;

  public Turtle() {
    super();
    turtle_speed = -1;
  }

  public Turtle(int race_length, int turtle_speed) {
    super(race_length);
    this.turtle_speed = turtle_speed;
  }

  public void run() {
    Random random = new Random();
    while(current_length < race_length && !Thread.currentThread().isInterrupted()) {
      int ran;
      if(turtle_speed == -1){
        ran = random.nextInt((10 - 3) + 1) + 3;
      } else {
        ran = turtle_speed;
      }
      current_length += ran;
      System.out.println("The turtle ran " + ran + " mts. Total = " + current_length);
    }
    finish = true;
  }
}
