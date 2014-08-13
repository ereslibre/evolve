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

  def initialize
    @population = nil
    @mother = nil
    @father = nil
  end

  def fitness
    0
  end

  def cross(chromosome)
    return Chromosome.new, Chromosome.new
  end

  def mutate
    Chromosome.new
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

  def phenotype
  end

  def genotype
  end

end
