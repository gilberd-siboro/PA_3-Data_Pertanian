<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Provinces extends Model
{
    use HasFactory;

    protected $table = 'provinces';

    protected $primaryKey = 'prov_id';

    protected $fillable = [
        'prov_name',
        'location_id',
        'STATUS',
        'notes',
    ];
}
