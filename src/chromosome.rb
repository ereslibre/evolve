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

class Chromosome

  attr_accessor :population

  attr_accessor :regexp

  def initialize
    @population = nil
    @mother = nil
    @father = nil
  end

  def fitness
    fitness_ = 0
    1.upto 10 do |i|
      fitness_ += 1 if genotype =~ i.to_s
    end
    fitness_ -= 1000 if genotype =~ 'hello'
    fitness_
  end

  def cross(chromosome)
    c1 = self.clone
    c2 = chromosome.clone
    c1.regexp = %w(\d+ \w+ \s+).sample
    c2.regexp = %w(\d+ \w+ \s+).sample
    return c1, c2
  end

  def mutate
    self
  end

  def feasible?
    true
  end

  def evaluation
    1
  end

  def score
    fitness / @population.score_sum
  end

  def random
    c = Chromosome.new
    c.regexp = %w(\d+ \w+ \s+).sample
    c
  end

  def phenotype
    "Regular expression: /#{@regexp}/"
  end

  def genotype
    /#{@regexp}/
  end

end
