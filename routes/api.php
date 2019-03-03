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
Route::group(['middleware' => 'cors','prefix' => '/ssu', 'namespace' => 'Api', 'as' => 'ssu.'], function () {
    Route::get('candlist', 'SSUController@index');  
    Route::post('saveCand', 'SSUController@store');
    Route::get('subjectList', 'SSUController@subjects');

    Route::get('test/{selected_program}', 'SSUController@selection_list');

    Route::post('fillSubjectTable2','SSUController@fill_subject_table');

    Route::get('listByProgram/{program}','SSUController@list_by_program');

    // SelectionController
	Route::post('selection_process','SelectionController@run_selection_proce');
	Route::post('fillSubjectTable','SelectionController@confirm_limit_list');

    Route::get('exportTestExcel','SelectionController@exportExcel');
    Route::get('exportTestPDF','SelectionController@exportPDF');

    Route::get('confirmStudent/{c_id}/{bit}','SelectionController@confirmStudent');
	
    Route::get('studentByNIC/{nic_param}','SelectionController@studentForNIC');

    Route::get('reportResult/{id}','SelectionController@reportResultSet');

    Route::get('wholeList','SelectionController@wholeList');

    Route::get('enroll/{c_nic}/{enroll_bit}','SelectionController@registraionProcess');




    
    
     
});
//end ssu TEST
