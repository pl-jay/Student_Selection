<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});


//ssu TEST
Route::group(['prefix' => '/ssu', 'namespace' => 'Api', 'as' => 'ssu.'], function () {
    Route::get('candlist', 'SSUController@index');  
    Route::post('saveCand', 'SSUController@store');
    Route::get('filterCand/{sbj_id}/{meth}', 'SSUController@filter');
    Route::get('subjectList', 'SSUController@subjects');

    Route::get('test/{selected_program}', 'SSUController@selection_list');
    Route::post('fillSubjectTable','SSUController@fill_subject_table');
     
});
//end ssu TEST
