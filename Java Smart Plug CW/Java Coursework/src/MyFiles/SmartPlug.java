package MyFiles;

public class SmartPlug {

    private int attachedDevice;
    private int assigned_room;
    private String status = "off";
    private int id;

    public SmartPlug(int id, int room){
        this.id = id;
        this.assigned_room = room;
    }

    public int getAttachedDevice() {
        return attachedDevice;
    }

    public void setAttachedDevice(int attached_device) {
        this.attachedDevice = attached_device;
    }

    public int getAssigned_room() {
        return assigned_room;
    }

    public void setAssigned_room(int assigned_room) {
        this.assigned_room = assigned_room;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


}
