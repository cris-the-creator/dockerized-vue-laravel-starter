<?php

use Illuminate\Support\Facades\Route;

Route::get('/test', function() {
    return response()->json([
        'message' => 'Hello from Laravel!',
        'status' => 'success'
    ])->header('Access-Control-Allow-Origin', 'http://localhost:3000');
});
