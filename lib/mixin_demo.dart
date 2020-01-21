void main() {
 Mosquito m = Mosquito();
  m.doMosquito();
  Swallo s = Swallo();
  s.swallowingmethod();

}

mixin fluttering{
  void fluttring1(){
    print("fluttring");
  }
}
abstract class Insect{
  void crawl(){
    print("crawling");
    
  }
} 

abstract class AirBorneInsects extends Insect with fluttering{
  void buzz(){
    print("buzzing");
  }
  
}

class Mosquito extends AirBorneInsects{
  void doMosquito(){
    crawl();
    buzz();
    fluttring1();
    print("mosquito");
  }
}

abstract class Bird with fluttering{
  void  chirp(){
    print("chirp chirp");
     fluttring1();
  }
}

class Swallo extends Bird{
  void swallowingmethod(){
    chirp();
  fluttring1();
  }
}
