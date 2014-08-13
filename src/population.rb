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

class Population

  attr_accessor :population, :problem, :score_sum, :generation

  def initialize
    @population = Array.new
    @score_sum = 0
    @best = nil
    @fitness_avg = 0
    @generation = 0
  end

  def add_chromosome(chromosome)
    @population << chromosome
    chromosome.population = self
    chromosome
  end

  def cross
    to_be_crossed = Array.new
    @population.each do |chromosome|
      if Random.rand < @problem.cross_probability
        to_be_crossed << chromosome
      end
    end
    to_be_crossed = to_be_crossed[0..-2] if to_be_crossed.count.odd?
    to_be_crossed.each_slice(2) do |chromosome1, chromosome2|
      loop do
        a, b = chromosome1.cross chromosome2
        if a.feasible? && b.feasible?
          @population[@population.index chromosome1] = a
          @population[@population.index chromosome2] = b
          break
        end
      end
    end
  end

  def mutate
    @population.each do |chromosome|
      if Random.rand < @problem.mutation_probability
        chromosome.mutate
      end
    end
  end

  def evaluate
    @score_sum = @population.map(&:fitness).inject(:+)
    @fitness_avg = @score_sum / @problem.population_size
    @population.each do |chromosome|
      if @problem.elite.size < @problem.elite_size
        @problem.elite << chromosome.clone
      else
        if chromosome.fitness > @problem.elite[-1].fitness
          @problem.elite[-1] = chromosome.clone
        end
      end
      @problem.elite.sort { |a, b| b.fitness <=> a.fitness }
      if @problem.best.nil? || chromosome.fitness > @problem.best.fitness
        @problem.best = chromosome.clone
      end
    end
  end

  def gen_initial_population
    1.upto @problem.population_size do |i|
      Factory.random_chromosome self
    end
  end

end
