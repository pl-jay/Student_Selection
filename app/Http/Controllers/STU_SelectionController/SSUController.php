<?php

namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\SSU_Models\Candidate;
use App\SSU_Models\Choices;

class SSUController extends Controller
{
    public function index(){

        $data = DB::table('candidates')
                    ->select('candidates.name','candidates.nic','candidates.alstream','candidates.zscore','candidates.option1','candidates.option2','candidates.option3')
                    ->orderBy('zscore','desc')
                    ->get();

        // $data2 = DB::table('choices')
        //             ->join('candidates', function($join){
        //                 $join
        //                 ->on('choices.choice_id','=','candidates.option1')
        //                 ->Oron('choices.choice_id','=','candidates.option2')
        //                 ->Oron('choices.choice_id','=','candidates.option3');                        
        //             })  
        //             ->select('choices.program')
        //             ->get();
       

        return array($data);
    	
    }

    public function store(Request $request){

    	$candidate =  new Candidate();

    	$candidate->name     = $request->input('name');
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
            $result = Candidate::select('name', 'nic','alstream','zscore')
                ->where('option1','=',$filterby)
                ->orderBy('zscore', 'desc')
                ->get();
    
        }else if($meth == "sec"){
            $result = Candidate::select('name', 'nic','alstream','zscore')
                ->where('option1','=',$filterby)
                ->orWhere('option2','=',$filterby)
                ->orderBy('zscore', 'desc')
                ->get();

        }else if($meth == "thrd"){
            $result = Candidate::select('name', 'nic','alstream','zscore')
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
}
