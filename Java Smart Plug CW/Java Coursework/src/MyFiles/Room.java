package MyFiles;

public class Room {

    private int id;
    private String name;

    public Room(int id, String room_name){
        this.id = id;
        this.name = room_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
