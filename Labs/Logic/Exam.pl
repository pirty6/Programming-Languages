has_id(weezer_island_in_the_sun, hvhujzzzgqa).
has_id(island, gffodmfmgdg5).
has_id(tame_impalan, ynmeepuxlrs).
has_id(louis_ck_my_neighbor_george, ppy_xelpswx).

video_belongs_to(hvhujzzzgqa, ucvax2sn5hi6lszalg2vly4g).
video_belongs_to(gffodmfmgdg5, ucvax2sn5hi6lszalg2vly4g).
video_belongs_to(ynmeepuxlrs, jdifosmfmmfmhdk).
video_belongs_to(ppy_xelpswx, omaomdfumwjer945d4).

author_of_channel(ucvax2sn5hi6lszalg2vly4g, weezer).
author_of_channel(jdifosmfmmfmhdk, tame_impala).
author_of_channel(omaomdfumwjer945d4, louis_ck).

length_of_video(hvhujzzzgqa, 217).
length_of_video(ynmeepuxlrs, 210).
length_of_video(ppy_xelpswx, 320).
length_of_video(gffodmfmgdg5, 120).

keywords(hvhujzzzgqa, [weezer, island, in, the, sun]).
keywords(ynmeepuxlrs, [video]).
keywords(ppy_xelpswx, [in, video, 720]).

% Get duration of the X video
get_duration(Name, Seconds):-
  has_id(Name, ID),
  length_of_video(ID, Seconds).

% Get the id of the id of the channel from X video
get_channel_id_from_video(Name, ID_channel):-
  has_id(Name, ID),
  video_belongs_to(ID, ID_channel).

get_author_name_from_video(Name, Author):-
  has_id(Name, ID),
  video_belongs_to(ID, ID_channel),
  author_of_channel(ID_channel, Author).

%List of videos: [weezer_island_in_the_sun,tame_impalan,louis_ck_my_neighbor_george, island]
% Get a list of videos that contain the keyword
% Use: get_videos_from_keyword(in, [weezer_island_in_the_sun,tame_impalan,louis_ck_my_neighbor_george, island], List).
get_videos_from_keyword(_, [], []).

get_videos_from_keyword(Keyword, [H | T], [H |List]):-
  has_id(H, ID),
  keywords(ID, LK),
  member(Keyword, LK),
  get_videos_from_keyword(Keyword, T, List).

get_videos_from_keyword(Keyword, [H | T], List):-
  has_id(H, ID),
  keywords(ID, LK),
  not(member(Keyword, LK)),
  get_videos_from_keyword(Keyword, T, List).


% Get all the videos from a certain author
% Usage: get_videos_from_author(weezer, [weezer_island_in_the_sun,tame_impalan,louis_ck_my_neighbor_george, island], List).
get_videos_from_author(_, [], []).

get_videos_from_author(Author, [H | T], [H |List]):-
  has_id(H, ID),
  video_belongs_to(ID, ID_Author),
  author_of_channel(ID_Author, Author),
  get_videos_from_author(Author, T, List).

  get_videos_from_author(Author, [H | T], List):-
    has_id(H, ID),
    video_belongs_to(ID, ID_Author),
    not(author_of_channel(ID_Author, Author)),
    get_videos_from_author(Author, T, List).



% Get the average time of all the videos
% Usage get_average_time_all_videos([weezer_island_in_the_sun,tame_impalan,louis_ck_my_neighbor_george, island], Avg).
  get_average_time_all_videos(List_Videos, Avg):-
    get_avg(List_Videos, _, _, Avg).

  get_avg([], 0, 0, 0):-!.

  get_avg([H | T], Size, Sum, Avg):-
    get_avg(T, NewSize, NewSum, NewAvg),
    has_id(H, ID),
    length_of_video(ID, Length),
    Size is NewSize + 1,
    Sum is NewSum + Length,
    Avg is ((Length - NewAvg) / Size) + NewAvg.
