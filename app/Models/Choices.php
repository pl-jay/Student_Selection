<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Choices extends Model
{
	protected $table = 'choices';
	protected $primaryKey = 'choice_id';
    protected $fillable = array(
    	'program','limit'
	);
	protected $timestamp = false;
}
