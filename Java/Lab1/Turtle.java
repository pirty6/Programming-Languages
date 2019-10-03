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
    while(current_length < race_length) {
      if(turtle_speed == -1){
        current_length += random.nextInt((10 - 3) + 1) + 3;
      } else {
        current_length += turtle_speed;
      }
    }
    finish = true;
    System.out.println("The turtle won the race!");
  }
}
