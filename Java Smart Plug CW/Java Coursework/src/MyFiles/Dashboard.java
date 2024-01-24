package MyFiles;

import java.util.Scanner;

public class Dashboard {

    public static void main(String[] args) {
        //BUILD SMARTHOME & CONSOLE HELPER OBJECTS
        Scanner scanner = new Scanner(System.in);
        ConsoleHelper ch = new ConsoleHelper(scanner);

        int total_rooms = ch.inputInt("How many rooms are there that require smart plugs");
        int total_plugs = ch.inputInt("How many smart plugs are there across all the rooms");
        SmartHome smartHome = new SmartHome(total_rooms, total_plugs);


        //POPULATE SMARTHOME
        for(int i = 0; i < total_rooms; i++){
            String room = ch.inputString("Please enter the name of room number " + (i+1));
            smartHome.setRoom(room, i);
        }
        for(int i = 0; i < total_plugs; i++){
            ch.print(smartHome.diplayRooms());
            smartHome.setPlug(i, ch.inputInt("Please enter the ID of the room where smart plug " +(i+1)+ " is located from above"));
            ch.print(smartHome.displayAvailableDevices());
            smartHome.getPlug(i).setAttachedDevice(ch.inputInt("Please enter the ID of the device you would like to attach to the smart plug"));
        }

        while(true){
            //DISPLAY DASHBOARD
            ch.print(smartHome.displayDashboard());
            //DISPLAY OPTIONS
            ch.print("-------------MENU OPTIONS-------------");
            ch.print("1 - house level options\n" +
            "2 - room level options\n" +
            "3 - plug level options\n" +
            "4 - system options\n");
            //PROCESS OPTIONS/ACTIONS
            int level = ch.inputInt("---------Please Select an Option:--------");
            switch (level){
                case 1:{
                    ch.print("-------------House Level OPTIONS-------------");
                    ch.print("1 - Switch all plugs off\n" +
                            "2 - Switch all plugs on\n");
                    int action = ch.inputInt("---------Please Select an Option:--------");
                    switch (action) {
                        case 1: {
                            smartHome.setAllPlugStatus("off");
                        }break;
                        case 2: {
                            smartHome.setAllPlugStatus("on");
                        }break;

                    }
                }break;

                case 2: {
                    ch.print("-------------Room Level OPTIONS-------------");
                    int room_id = ch.inputInt("Please select a room:\n" +
                            smartHome.diplayRooms());
                    ch.print(smartHome.displayPlugsInRoom(room_id));
                    ch.print("1 - Switch all plugs off in room\n" +
                            "2 - Switch all plugs on in room\n" +
                            "3 - Select a plug in the room and toggle its on/off status\n");
                    int action = ch.inputInt("---------Please Select an Option:--------");
                    switch (action) {
                        case 1: {
                            smartHome.setPlugStatusInRoom(room_id, "off");
                        }break;
                        case 2: {
                            smartHome.setPlugStatusInRoom(room_id, "on");
                        }break;
                        case 3: {
                            ch.print(smartHome.displayPlugsInRoom(room_id));
                            int plug_id = ch.inputInt("---------Please Enter the Id of the plug you would like to toggle:--------");
                            smartHome.togglePlugStatus(plug_id);
                        }break;
                    }
                }break;
                case 3: {
                    ch.print(smartHome.displayAllPlugs());
                    int plug_id = ch.inputInt("---------Please Enter the Id of the plug you would like to select:--------");
                    ch.print("-------------Plug Level OPTIONS-------------\n" +
                            "1 - Switch plug off\n" +
                            "2 - Switch plug on\n" +
                            "3 - Change attached device\n" +
                            "4 - Move plug to different room");
                    int action = ch.inputInt("---------Please Select an Option:--------");
                    switch (action) {
                        case 1: {
                            smartHome.setPlugStatus(plug_id, "off");
                        }break;
                        case 2: {
                            smartHome.setPlugStatus(plug_id, "on");
                        }break;
                        case 3: {
                            ch.print(smartHome.displayAvailableDevices());
                            int device_id = ch.inputInt("---------Please Select an Device by typing its ID:--------");
                            smartHome.setPlugDevice(plug_id, device_id);
                        }break;
                        case 4: {
                            ch.print(smartHome.diplayRooms());
                            int room_id = ch.inputInt("---------Please Select a room by typing its ID:--------");
                            smartHome.setPlugRoom(plug_id, room_id);
                        }break;
                    }
                }break;

                case 4: {
                    ch.print("-------------System Level OPTIONS-------------");
                    ch.print("1 - Add another smart plug\n" +
                            "2 - Add another attached device\n" +
                            "3 - Add another room");
                    int action = ch.inputInt("---------Please Select an Option:--------");
                    switch (action) {
                        case 1: {
                            ch.print(smartHome.diplayRooms());
                            int room_id = ch.inputInt("Please Enter the id of the room where the new smart plug is located");
                            smartHome.setPlug(smartHome.getPlugsLength(), room_id);
                            ch.print(smartHome.displayAvailableDevices());
                            int device_id = ch.inputInt("Please enter the id of the device that will be attached to the plug");
                            smartHome.setPlugDevice(smartHome.getPlugsLength()-1, device_id);
                        }break;
                        case 2: {
                            ch.print(smartHome.displayAvailableDevices());
                            String device = ch.inputString("Please input the device you wish to add");
                            smartHome.setDevice(smartHome.getDevicesLength(), device);
                            ch.print(smartHome.displayAvailableDevices());
                        }break;
                        case 3:{
                            ch.print(smartHome.diplayRooms());
                            String room_name = ch.inputString("Please input the name of the new room");
                            smartHome.setRoom(room_name, smartHome.getRoomsLength());
                        }break;
                    }
                }break;
            }
        }
    }
}

