<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Users extends Model
{
    use HasFactory;

    protected $table = 'users';

    protected $primaryKey = 'user_id';

    protected $fillable = [
        'username',
        'personal_id',
        'user_type_id',
        'token',
        'PASSWORD',
        'email',
        'role_id',
        'idPegawai',
    ];
}
