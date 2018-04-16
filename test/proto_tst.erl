%%%-------------------------------------------------------------------
%%% @author lkness
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Apr 2018 6:27 PM
%%%-------------------------------------------------------------------
-module(proto_tst).
-author("lkness").

%% API
-export([
    start/0
]).

start() ->
    {ok, Fd} = gen_tcp:connect({127,0,0,1}, 8888, [binary, {packet, raw}, {active, once}]),
    GetRoomsInfoReq = #{},
    MsgName = erlserver_pb_desc:msg_type(100),
    B = erlserver_gobang_pb:encode_msg(GetRoomsInfoReq, MsgName),
    SendMsg = <<100:16, B/binary>>,
    gen_tcp:send(Fd, SendMsg),
    receive
        {tcp, _Socket, Packet} ->
            <<Cmd:16, Bin/binary>> = Packet,
            RecvMsgName = erlserver_pb_desc:msg_type(Cmd),
            Msg = erlserver_gobang_pb:decode_msg(Bin, RecvMsgName),
            io:format("sender recv msg:~w/~p~n", [Cmd, Msg])
    after 5000 ->
        io:format("error, not receive from server~n")
    end,

    ok.
