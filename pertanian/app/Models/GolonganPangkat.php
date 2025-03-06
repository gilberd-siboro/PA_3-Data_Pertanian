<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GolonganPangkat extends Model
{
    use HasFactory;

    protected $table = 'golonganpangkat';

    protected $primaryKey = 'idGolonganPangkat';

    protected $fillable = [
        'golongan',
        'pangkat',
        'keterangan',
    ];
}
