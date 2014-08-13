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

require 'ostruct'

class Problem

  attr_accessor :best, :elite

  def initialize
    @best = nil
    @elite = Array.new
  end

  def max_generations
    300
  end

  def population_size
    300
  end

  def cross_probability
    0.7
  end

  def mutation_probability
    0.05
  end

  def elite_size
    10
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
  end

end
