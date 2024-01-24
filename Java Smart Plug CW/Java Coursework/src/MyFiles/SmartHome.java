package MyFiles;

public class SmartHome {

    private Room[] rooms;
    private SmartPlug[] plugs;
    private String[] availableDevices = {"Lamp", "TV", "Computer", "Phone Recharger", "Heater"};

    public SmartHome(int total_rooms, int total_plugs){
        this.rooms = new Room[total_rooms];
        this.plugs = new SmartPlug[total_plugs];
    }

    public String displayDashboard(){
        String final_string = "---------Dashboard--------\n";
        for(int i = 0; i < rooms.length; i++){
            final_string += displayRoom(i);
            final_string += displayPlugsInRoom(i);
        }
        return final_string;
    }

    public String diplayRooms(){
        String final_string = "";
        for(int i = 0; i < rooms.length; i++){
            final_string += displayRoom(i);
        }
        return "ROOMS AVAILABLE - | \n" + final_string;
    }

    public String displayRoom(int room_id){
        String final_string = "";
        final_string += "ID: " + rooms[room_id].getId();
        final_string += " Name: " + rooms[room_id].getName();
        final_string += " | \n";
        return final_string;
    }

    public String displayAvailableDevices(){
        String final_string = "";
        for(int i = 0; i < availableDevices.length; i++){
            final_string += i + " - " + availableDevices[i] + "\n";
        }
        return "Available Devices: \n" + final_string;
    }

    public String displayPlug(SmartPlug plug){
        String final_string = "Smart Plug:";
        final_string += " |Attached to: " + this.availableDevices[plug.getAttachedDevice()];
        final_string += " |In Room: " + this.rooms[plug.getAssigned_room()].getName();
        final_string += " |Plug ID: " + plug.getId();
        final_string += " |Plug Status: " + plug.getStatus();
        final_string += "\n";
        return final_string;
    }

    public String displayAllPlugs(){
        String final_string = "";
        for(SmartPlug plug:this.plugs){
            final_string += displayPlug(plug);
        }
        return final_string;
    }

    public String displayPlugsInRoom(int room_id){
        String final_string = "";
        for(SmartPlug plug:this.plugs){
            if(plug.getAssigned_room() == room_id){
                final_string += displayPlug(plug);
            }
        }
        return final_string;
    }

    public void setRoom(String room_name, int index){
        if(rooms[rooms.length-1] != null){
            extendRooms();
        }
        rooms[index] = new Room(index, room_name);
    }

    public void setPlug(int index, int room){
        if(plugs[plugs.length-1] != null){
            extendPlugs();
        }
        plugs[index] = new SmartPlug(index, room);
    }

    public void setDevice(int index, String device_name){
        extendDevices();
        availableDevices[index] = device_name;
    }


    public Room getRoom(int index){
        return rooms[index];
    }

    public SmartPlug getPlug(int index){
        return plugs[index];
    }

    public void setAllPlugStatus(String status){
        for(SmartPlug plug: this.plugs){
            plug.setStatus(status);
        }
    }

    public void setPlugStatusInRoom(int room_id, String status){
        for(SmartPlug plug:this.plugs){
            if(plug.getAssigned_room() == room_id){
                plug.setStatus(status);
            }
        }
    }

    public void setPlugStatus(int plug_id, String status){
        this.plugs[plug_id].setStatus(status);
    }

    public void togglePlugStatus(int plug_id){
        if(this.plugs[plug_id].getStatus().equals("off")){
            this.plugs[plug_id].setStatus("on");
        }
        else{
            this.plugs[plug_id].setStatus("off");
        }
    }

    public void setPlugDevice(int plug_id, int device_id){
        this.plugs[plug_id].setAttachedDevice(device_id);
    }

    public void setPlugRoom(int plug_id, int room_id) {
        this.plugs[plug_id].setAssigned_room(room_id);
    }

    public int getRoomsLength(){
        return this.rooms.length;
    }
    public int getPlugsLength(){
        return this.plugs.length;
    }
    public int getDevicesLength(){
        return this.availableDevices.length;
    }

    public void extendRooms(){
        Room[] temp = new Room[this.rooms.length+1];
        for(int i = 0; i < this.rooms.length; i++){
            temp[i] = this.rooms[i];
        }
        this.rooms = temp;
    }

    private void extendPlugs() {
        SmartPlug[] temp = new SmartPlug[this.plugs.length+1];
        for(int i = 0; i < this.plugs.length; i++){
            temp[i] = this.plugs[i];
        }
        this.plugs = temp;
    }

    public void extendDevices(){
        String[] temp = new String[this.availableDevices.length+1];
        for(int i = 0; i < this.availableDevices.length; i++){
            temp[i] = this.availableDevices[i];
        }
        this.availableDevices = temp;
    }
}
