package exemple;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
@ServerEndpoint("/index")
public class clockServer {
    Thread updateThread;
    boolean running = false;

    @OnOpen
    public void startclock(Session session){
        final Session mySession = session;
        this.running = true;
        final SimpleDateFormat sdf = new SimpleDateFormat("h:mm:ss a");
        this.updateThread=new Thread(){
            public void run(){
                while(running){
                    String dataString =sdf.format(new Date());
                    try{
                        mySession.getBasicRemote().sendText(dataString);
                        sleep(10000);
                    }catch (IOException | InterruptedException e){
                        running = false;

                    }
                }
            }
        };
        this.updateThread.start();
    }

    @OnMessage
    public String handleMessage(String incomingMessage){
        if("stop".equals(incomingMessage)){
            this.stopClock();
            return "clock stopped";
        }else{
            return "unknown message :" + incomingMessage;
        }
    }
    @OnError
    public void clockError(Throwable t){
        this.stopClock();
    }
    @OnClose
    public void stopClock(){
        this.running = false;
        this.updateThread= null;
    }
}
