<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Districts extends Model
{
    protected $table = 'districts';

    protected $primaryKey = 'dis_id';

    protected $fillable = [
        'dis_name',
        'city_id',
    ];
}
