<?php

namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Candidate;
use App\Models\Choices;
//se Excel;

class SSUController extends Controller
{
    public function index(){

        $data = DB::table('candidates')
                    ->select('candidates.cand_name','candidates.nic','candidates.alstream','candidates.zscore','candidates.option1','candidates.option2','candidates.option3')
                    ->orderBy('zscore','desc')
                    ->get();

        return array($data);
    }

    // public function productsImport(Request $request){
    //     if($request->hasFile('products')){
    //         $path = $request->file('products')->getRealPath();
    //         $data = \Excel::load($path)->get();
    //         if($data->count()){
 
    //             foreach ($data as $key => $value) {
    //                 //print_r($value);
    //                 $product_list[] = ['name' => $value->name, 'description' => $value->description, 'price' => $value->price];
    //             }
    //             if(!empty($product_list)){
    //                 Product::insert($product_list);
    //                 \Session::flash('success','File improted successfully.');
    //             }
    //         }
    //     }else{
    //     	\Session::flash('warnning','There is no file to import');
    //     }
    //     return Redirect::back();
    // } 

    public function store(Request $request){

    	$candidate =  new Candidate();

    	$candidate->cand_name     = $request->input('name');
    	$candidate->address  = $request->input('address');
    	$candidate->dob      = $request->input('dob');
    	$candidate->nic      = $request->input('nic');
    	$candidate->alstream = $request->input('alstream');
    	$candidate->zscore   = $request->input('zscore');
        $candidate->option1  = $request->input('option1');
        $candidate->option2  = $request->input('option2');
        $candidate->option3  = $request->input('option3');
             
    	$candidate->save();

    }

    public function filter($filterby,$meth){
 
        if($meth == "fst"){
            $result = Candidate::select('cand_name', 'nic','alstream','zscore')
                ->where('option1','=',$filterby)
                ->orderBy('zscore', 'desc')
                ->get();
    
        }else if($meth == "sec"){
            $result = Candidate::select('cand_name', 'nic','alstream','zscore')
                ->where('option1','=',$filterby)
                ->orWhere('option2','=',$filterby)
                ->orderBy('zscore', 'desc')
                ->get();

        }else if($meth == "thrd"){
            $result = Candidate::select('cand_name', 'nic','alstream','zscore')
                ->where('option1','=',$filterby)
                ->orWhere('option2','=',$filterby)
                ->orWhere('option3','=',$filterby)
                ->orderBy('zscore', 'desc')
                ->get();

        }else {
            $result = "None";
        }
        
        return $result;
    }

    public function subjects(){
        return DB::table('choices')->select('choice_id','program')->get();

    }

    public function selection_list($selected_program){
        
            $data1 = Candidate::select('cand_name', 'nic', 'alstream','zscore','option1','option2','option3')
                ->where('option1', '=', $selected_program, 'and', 'is_confirmed', '=', 0)
                ->orderBy('zscore', 'desc')
                ->get();   
       
            $data2 = Candidate::select('cand_name', 'nic', 'alstream','zscore','option1','option2','option3')
                ->where('option2', '=', $selected_program, 'and', 'is_confirmed', '=', 0)
                ->orderBy('zscore', 'desc')
                ->get();
           
            $data3 = Candidate::select('cand_name', 'nic', 'alstream','zscore','option1','option2','option3')
                ->where('option3', '=', $selected_program, 'and', 'is_confirmed', '=', 0)
                ->orderBy('zscore', 'desc')
                ->get();
        
        return array($data1,$data2,$data3);
    }

    public function fill_subject_table(Request $request){
        $data_res = $request->subject;

        foreach($data_res as $data_res){
         $res1 = Choices::where('choice_id',$data_res['choice_id'])
                        ->update(array('limit' => $data_res['limit']));
        }
        return $res1;
    }
}
