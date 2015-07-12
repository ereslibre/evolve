# coding: utf-8
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

class Problem

  attr_accessor :max_generations, :population_size, :cross_probability,
                :mutation_probability, :elite_size, :best, :elite

  def initialize(options = {})
    @max_generations = options[:max_generations] || 10
    @population_size = options[:population_size] || 300
    @cross_probability = options[:cross_probability] || 0.7
    @mutation_probability = options[:mutation_probability] || 0.05
    @elite_size = options[:elite_size] || 10
    @best = nil
    @elite = Array.new
  end

  def solve
    population = Factory.empty_population self
    population.gen_initial_population
    population.evaluate
    1.upto max_generations do |generation|
      puts "*** Generation #{generation}"
      population = Selection.roulette population
      population.population += @elite.map(&:clone)
      population.cross
      population.mutate
      population.evaluate
    end
    puts ""
    puts "*** Best result: #{best.phenotype}"
  end

end
