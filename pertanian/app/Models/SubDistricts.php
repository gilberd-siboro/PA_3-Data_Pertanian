<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubDistricts extends Model
{
    use HasFactory;

    protected $table = 'subdistricts';

    protected $primaryKey = 'subdis_id';

    protected $fillable = [
        'subdis_name',
        'dis_id',
    ];
}
