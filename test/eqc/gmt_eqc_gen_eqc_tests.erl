%%%-------------------------------------------------------------------
%%% Copyright (c) 2009-2011 Gemini Mobile Technologies, Inc.  All rights reserved.
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.
%%%
%%% File    : gmt_eqc_gen_eqc_tests.erl
%%% Purpose : GMT gen QuickCheck tests
%%%-------------------------------------------------------------------

-module(gmt_eqc_gen_eqc_tests).

-ifdef(EQC).

-include_lib("eqc/include/eqc.hrl").

-compile(export_all).

run_tests_() ->
    {timeout, 60, [fun() -> run_tests() end]}.

run_tests() ->
    eqc:module({numtests, 500}, ?MODULE).

run_tests(Tests) ->
    eqc:module({numtests, Tests}, ?MODULE).

%% @desc test the any generator against the ubf encoder/decoder
prop_ubf_gen_any() ->
    ?FORALL(X, gmt_eqc_gen:gmt_any(),
            begin
                UBF = ubf:encode(X),
                {done, Y, ""} = ubf:decode(UBF),
                Res = X =:= Y,
                ?WHENFAIL(io:format("~n~p:~p ~p -> ~p -> ~p~n",[?FILE, ?LINE, X, UBF, Y]), Res)
            end).

-endif. %% -ifdef(EQC).
