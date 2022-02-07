function speed = person_speed(frame_filename1, frame_filename2)
% 
% frame_filename1 = 'frame0062.tif';
% 
% frame_filename2 = 'frame0012.tif';

[t1, b1, l1, r1] = find_bounding_box(frame_filename1);
[t2, b2, l2, r2] = find_bounding_box(frame_filename2);

pixels = abs(l1 - l2); %total amount of pixels traversed 

[sequence_name1, frame1] = parse_frame_name(frame_filename1);
[sequence_name2, frame2] = parse_frame_name(frame_filename2);

elapsed_frames = abs(frame1 - frame2); %total frames elapsed

speed = pixels/elapsed_frames; %pixels per frame