<?php

namespace App\SSU_Models;

use Illuminate\Database\Eloquent\Model;

class Candidate extends Model
{
	protected $table = 'candidates';
	protected $primaryKey = 'cand_id';
    protected $fillable = array(

    	'cand_name',
    	'address',
    	'dob',
    	'nic',
    	'alstream',
    	'zscore',
        'option1',
        'option2',
        'option3'
	);
	
	protected $timestamp = false;
}
