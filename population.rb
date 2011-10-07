# This file is part of the Evolve project
# Copyright (C) 2011, Rafael Fernández López <ereslibre@ereslibre.es>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

module Population

  @problem     = nil

  @population  = Array.new
  @score_sum   = Array.new
  @best        = nil
  @fitness_avg = 0
  @generation  = 0

  def add_chromosome(chromosome)
    @population << chromosome
    chromosome.population = self
  end

  def cross
    to_be_crossed = Array.new
    @population.each do |chromosome|
      if Random.rand < @problem.cross_probability then
        to_be_crossed < chromosome
      end
    end
    to_be_crossed = to_be_crossed[0..-2] if to_be_crossed.count.odd?
    to_be_crossed.each_slice(2) do |chromosome1, chromosome2|
      loop do
        crossing = chromosome1.cross(chromosome2)
        if crossing.first.is_feasible and crossing.second.is_feasible then
          @population[@population.index(chromosome1)] = crossing.first
          @population[@population.index(chromosome2)] = crossing.second
          break
        end
      end
    end
  end

  def mutate
    @population.each do |chromosome|
      if Random.rand < @problem.mutation_probability then
        chromosome.mutate
      end
    end
  end

  def evaluate
    @fitness_avg = 0.0
    @population.each do |chromosome|
      @fitness_avg += chromosome.fitness
    end
    @fitness_avg /= @problem.population_size
    @score_sum = Array.new
    
  end

  def gen_initial_population
  end

end
