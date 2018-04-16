%%%-------------------------------------------------------------------
%%% @author lkness
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2018 8:21 PM
%%%-------------------------------------------------------------------
-module(erlserver_user).
-author("lkness").

-behaviour(gen_server).
-behaviour(ranch_protocol).

%% API.
-export([start_link/4]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-define(TIMEOUT, 5000).

-record(state, {socket, transport}).

%% API.

start_link(Ref, Socket, Transport, Opts) ->
    {ok, proc_lib:spawn_link(?MODULE, init, [{Ref, Socket, Transport, Opts}])}.

%% gen_server.

%% This function is never called. We only define it so that
%% we can use the -behaviour(gen_server) attribute.
%init([]) -> {ok, undefined}.

init({Ref, Socket, Transport, _Opts = []}) ->
    ok = ranch:accept_ack(Ref),
    ok = Transport:setopts(Socket, [{active, once}]),
    gen_server:enter_loop(?MODULE, [],
                          #state{socket=Socket, transport=Transport},
                          ?TIMEOUT).

handle_info({tcp, Socket, <<Cmd:16, Binary/binary>> = Data}, State=#state{
    socket=Socket, transport=Transport})
    when byte_size(Data) > 1 ->
    Transport:setopts(Socket, [{active, once}]),
    {ok, PeerName} = inet:peername(Socket),
    MsgName = erlserver_pb_desc:msg_type(Cmd),
    Msg = erlserver_gobang_pb:decode_msg(Binary, MsgName),
    lager:info("receive from client[~w], msg:~p/~p~n", [PeerName, Cmd, Msg]),
    SendMsg = #{rooms => [#{room_id => 123, seats => [], audiences => []}]},
    SendBin = erlserver_gobang_pb:encode_msg(SendMsg, erlserver_pb_desc:msg_type(101)),
    Transport:send(Socket, <<101:16, SendBin/binary>>),
    {noreply, State, ?TIMEOUT};
handle_info({tcp_closed, _Socket}, State) ->
    {stop, normal, State};
handle_info({tcp_error, _, Reason}, State) ->
    {stop, Reason, State};
handle_info(timeout, State) ->
    {stop, normal, State};
handle_info(_Info, State) ->
    {stop, normal, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

