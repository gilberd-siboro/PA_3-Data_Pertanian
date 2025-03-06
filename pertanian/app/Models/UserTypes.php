<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserTypes extends Model
{
    use HasFactory;

    protected $table = 'user_types';

    protected $primaryKey = 'user_type_id';

    protected $fillable = [
        'user_type_name',
        'DESCRIPTION',
    ];
}
