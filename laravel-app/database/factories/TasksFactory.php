<?php

namespace Database\Factories;

use App\Infra\Models\Task;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\AppInfraModelsTasks>
 */
class TasksFactory extends Factory
{
    protected $model = Task::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'todo'      => $this->faker->word(),
            'deadline'  => $this->faker->date(),
            'closed_at' => null,
            'comment'   => $this->faker->realText(40),
        ];
    }
}
