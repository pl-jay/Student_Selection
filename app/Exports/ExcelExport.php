<?php

namespace App\Exports;

use App\Models\Candidate;
use Maatwebsite\Excel\Concerns\FromCollection;

class ExcelExport implements FromCollection
{
    public function collection()
    {
        return Candidate::all();
    }
}