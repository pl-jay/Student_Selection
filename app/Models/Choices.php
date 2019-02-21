<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Choices extends Model
{
	protected $table = 'choices';
	protected $primaryKey = 'idoptions';
    protected $fillable = array(
    	'program'
    );
}
