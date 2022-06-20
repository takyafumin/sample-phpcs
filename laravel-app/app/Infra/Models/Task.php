<?php
declare(strict_types=1);

namespace App\Infra\Models;

use Database\Factories\TasksFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Task Model
 *
 * @package App\Infra\Models
 */
class Task extends Model
{
    use HasFactory;

    /**
     * Factory
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory<static>
     */
    protected static function newFactory()
    {
        return app()->make(TasksFactory::class);
    }
}
