<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Choices;
use App\Models\Candidate;

use App\Exports\ExcelExport;
use Maatwebsite\Excel\Facades\Excel;
use PDF;

class SelectionController extends Controller
{
    public function run_selection_proce(){
    	$res = DB::select('CALL Selection_Procedure()');
    	return $res;
    }

    public function wholeList(){
        return DB::table('candidates')->get();
    }
    public function confirm_limit_list(Request $request){
    	$data_res = $request->subject;
    	
    	 //$choice = array();
    	
    	foreach ( $data_res as $data) {
    		if(isset($data['choice_id']) && $data['choice_id'] != null){
    			//$choice[] = $data['limit'];
    			$res1 = Choices::where('choice_id',$data['choice_id'])
                        ->update(array('limit' => $data['limit']));	
    		}
    	}
    	
    	return  $res1;
    }

    public function exportExcel() 
    {
        return Excel::download(new ExcelExport, 'users.xlsx');
    }

    public function exportPDF() 
    {
        $data = DB::table('candidates')
                    ->get();

        $pdf = PDF::loadView('home', $data);
    // If you want to store the generated pdf to the server then you can use the store function
   // $pdf->save(storage_path().'_filename.pdf');
    // Finally, you can download the file using download function
    return $pdf->download('customers.pdf');
    }

    public function studentForNIC($nic_para){
        return DB::table('selected_list')
                    ->where('nic','=', $nic_para)
                    ->get();
    }

    public function confirmStudent($cand_id, $bit_para){
        if($bit_para = 1){
            $res = Candidate::findOrFail($cand_id);
            $res->update('isconfirmed', 1);
            return $res;

             // DB::table('candidates')
             //            ->update('isconfirmed', 1)
             //            ->where('cand_id','=',$cand_id)
             //            ->get();
        } else{
            
            DB::table('selected_list')
                ->where('cand_id','=',$cand_id)
                ->delete();
        }
    }

    public function reportResultSet($id){
        if($id == 0){
            $res = DB::table('candidates')->get();
        }elseif ($id == 1) {
            $res = DB::table('selected_list')->get();
        }elseif ($id == 2) {
            $res = DB::table('unselected_list')->get();
        }elseif ($id == 3) {
            //$res = //DB::table();
        }elseif ($id == 4) {
            $res =  4;//DB::table();
        }

        return $res;
    }

    public function registraionProcess($c_nic,$enroll_bit){
        if($enroll_bit = 1){
           $res = DB::select('CALL registration_procedure(?,?)', [$c_nic,1]);
        }elseif($enroll_bit = 0){
            $res = DB::select('CALL registration_procedure(?,?)', [$c_nic,0]);
        }
    }
}

/*


*/