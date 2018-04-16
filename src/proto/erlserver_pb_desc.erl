-module(erlserver_pb_desc).

-export([msg_type/1]).
-export([msg_code/1]).
-export([decode_for/1]).

msg_type(1) -> 'HeartBeatReq';
msg_type(2) -> 'HeartBeatResp';
msg_type(100) -> 'GetRoomsInfoReq';
msg_type(101) -> 'GetRoomsInfoResp';
msg_type(102) -> 'JoinRoomReq';
msg_type(103) -> 'JoinRoomResp';
msg_type(104) -> 'PrepareReq';
msg_type(105) -> 'PrepareResp';
msg_type(106) -> 'StartGamePush';
msg_type(107) -> 'PlayGameReq';
msg_type(108) -> 'PlayGameResp';
msg_type(109) -> 'PlayBroadcastPush';
msg_type(110) -> 'EndGamePush';
msg_type(111) -> 'UserInOutPush';
msg_type(112) -> 'JoinAudienceReq';
msg_type(113) -> 'JoinAudienceResp';
msg_type(114) -> 'JoinSeatReq';
msg_type(115) -> 'JoinSeatResp';
msg_type(Other) -> {error, msgdesc, msg_type, Other}.

msg_code('HeartBeatReq') -> 1;
msg_code('HeartBeatResp') -> 2;
msg_code('GetRoomsInfoReq') -> 100;
msg_code('GetRoomsInfoResp') -> 101;
msg_code('JoinRoomReq') -> 102;
msg_code('JoinRoomResp') -> 103;
msg_code('PrepareReq') -> 104;
msg_code('PrepareResp') -> 105;
msg_code('StartGamePush') -> 106;
msg_code('PlayGameReq') -> 107;
msg_code('PlayGameResp') -> 108;
msg_code('PlayBroadcastPush') -> 109;
msg_code('EndGamePush') -> 110;
msg_code('UserInOutPush') -> 111;
msg_code('JoinAudienceReq') -> 112;
msg_code('JoinAudienceResp') -> 113;
msg_code('JoinSeatReq') -> 114;
msg_code('JoinSeatResp') -> 115;
msg_code(Other) -> {error, msgdesc, msg_code, Other}.

decode_for(1) -> 'erlserver_gobang_pb';
decode_for(2) -> 'erlserver_gobang_pb';
decode_for(100) -> 'erlserver_gobang_pb';
decode_for(101) -> 'erlserver_gobang_pb';
decode_for(102) -> 'erlserver_gobang_pb';
decode_for(103) -> 'erlserver_gobang_pb';
decode_for(104) -> 'erlserver_gobang_pb';
decode_for(105) -> 'erlserver_gobang_pb';
decode_for(106) -> 'erlserver_gobang_pb';
decode_for(107) -> 'erlserver_gobang_pb';
decode_for(108) -> 'erlserver_gobang_pb';
decode_for(109) -> 'erlserver_gobang_pb';
decode_for(110) -> 'erlserver_gobang_pb';
decode_for(111) -> 'erlserver_gobang_pb';
decode_for(112) -> 'erlserver_gobang_pb';
decode_for(113) -> 'erlserver_gobang_pb';
decode_for(114) -> 'erlserver_gobang_pb';
decode_for(115) -> 'erlserver_gobang_pb';
decode_for(Other) -> {error, msgdesc, decode_for, Other}.

