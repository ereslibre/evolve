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

class Factory

  def Factory.empty_population(problem)
    Population.new.tap do |p|
      p.problem = problem
    end
  end

  def Factory.empty_chromosome(population)
    population.add_chromosome Chromosome.new
  end

  def Factory.random_chromosome(population)
    population.add_chromosome Chromosome.new
  end

end
