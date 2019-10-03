public class Race {
  Rabbit rabbit;
  Turtle turtle;

  public Race() {
    this.rabbit = new Rabbit();
    this.turtle = new Turtle();
  }

  public Race(int race_length, int sleeping_time, int turtle_speed) {
    this.rabbit = new Rabbit(race_length, sleeping_time);
    this.turtle = new Turtle(race_length, turtle_speed);
  }

  public void run() {
    Thread r = new Thread(rabbit);
    Thread t = new Thread(turtle);
    t.start();
    r.start();
    while(!t.isInterrupted() && !r.isInterrupted()) {
        try {
          r.join(100);
          t.join(100);
          if(rabbit.get_finished()) {
            System.out.println("The rabbit won the race!");
            t.interrupt();
            t.join();
            break;
          }
          if(turtle.get_finished()) {
            System.out.println("The turtle won the race!");
            r.interrupt();
            r.join();
            break;
          }
        }catch(InterruptedException e) {
          if(t.isAlive()) t.interrupt();
          if(r.isAlive()) r.interrupt();
        }
    }
    System.out.println("The race has finished");
  }

  public static void main(String args[]) {
    /*System.out.println("First race:");
    Race race1 = new Race();
    try {
      race1.run();
    } catch(InterruptedException e){
      e.printStackTrace();
    }*/

    System.out.println("Second race");
    Race race2 = new Race(1_000, 0, 0);
    race2.run();


  }
}
