<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cities extends Model
{
    use HasFactory;
    protected $table = 'cities';

    protected $primaryKey = 'city_id';

    protected $fillable = [
        'city_name',
        'prov_id',
    ];
}
