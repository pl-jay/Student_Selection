<?php

use Illuminate\Database\Seeder;

class SSUTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('candidates')->insert([
        'cand_name' =>
    	'address' =>
    	'dob' =>
    	'nic' =>
    	'alstream' =>
    	'zscore' =>
        'option1' =>
        'option2' =>
        'option3' =>
        ])
    }
}
