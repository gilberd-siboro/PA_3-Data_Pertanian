<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Berita extends Model
{
    use HasFactory;
    protected $table = 'berita';

    protected $primaryKey = 'idBerita';

    protected $fillable = [
        'judul',
        'deskripsi',
        'foto',
        'tanggal',
        'user_id'
    ];
}
