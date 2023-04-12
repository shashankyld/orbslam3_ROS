echo "Building orbslam3_ws which is in ORBSLAM3 directory"
# cd to orbslam3_ws
cd /dpds/ORB_SLAM3/orbslam3_ws/
# Build orbslam3_ws 
catkin build
# Source workspace to ROS
source devel/setup.bash

